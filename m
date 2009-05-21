From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [PATCH 1/1] dm-ioband: I/O bandwidth controller
Date: Thu, 21 May 2009 12:22:03 +0900 (JST)
Message-ID: <20090521.122203.193689175.ryov__746.634559664194$1242876399$gmane$org@valinux.co.jp>
References: <20090519.173928.226784958.ryov@valinux.co.jp>
	<20090519.174352.71107893.ryov@valinux.co.jp>
	<20090519133753.GA28679@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090519133753.GA28679@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vgoyal@redhat.com
Cc: containers@lists.linux-foundation.org, dm-devel@redhat.com, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Vivek,

> Anyway, how are you taking care of priorities with-in same class. How will
> you make sure that a BE prio 0 request is not hidden behind BE prio 7
> request? Same is true for prio with-in RT class.

I changed io_limit parameter of dm-ioband and ran your test script
again. io_limit is a parameter which determines how many IO requests
can be hold in dm-ioband. Its default value is equal to nr_requests of
the underlying device. I increased the value from 128 to 256 on this
test, because the writer requests IOs more than nr_requests.
The following result shows that dm-ioband does not break the notion of
CFQ priority. I think that the impact of dm-ioband's internal queue on
CFQ is insignificant, because the queue is not too long. The notion of
CFQ priority is preserved within each bandwidth group.

Setting
-------
ioband1: 0 112455000 ioband 8:18 share1 4 256 user weight 512 :40
                                          ^^^ io_limit

Script
------
#!/bin/bash
rm /mnt1/aggressivewriter
sync
echo 3 >  /proc/sys/vm/drop_caches
# launch an hostile writer
ionice -c2 -n7 dd if=/dev/zero of=/mnt1/aggressivewriter bs=4K \
        count=524288 conv=fdatasync &
# Reader
ionice -c2 -n0 dd if=/mnt1/testzerofile1 of=/dev/null &
wait $!
echo "reader finished"

Without dm-ioband
-----------------
First run
2147483648 bytes (2.1 GB) copied, 34.8201 seconds, 61.7 MB/s (Reader)
reader finished
2147483648 bytes (2.1 GB) copied, 68.9099 seconds, 31.2 MB/s (Writer)

Second Run
2147483648 bytes (2.1 GB) copied, 34.8201 seconds, 61.7 MB/s (Reader)
reader finished
2147483648 bytes (2.1 GB) copied, 68.9099 seconds, 31.2 MB/s (Writer)

With dm-ioband
--------------
First run
2147483648 bytes (2.1 GB) copied, 35.852 seconds, 59.9 MB/s  (Reader)
reader finished
2147483648 bytes (2.1 GB) copied, 73.3991 seconds, 29.3 MB/s (Writer)

Second Run
2147483648 bytes (2.1 GB) copied, 36.0273 seconds, 59.6 MB/s (Reader)
reader finished
2147483648 bytes (2.1 GB) copied, 72.8979 seconds, 29.5 MB/s (Writer)

For reference, the previous test results.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-04/msg08345.html

Thanks,
Ryo Tsuruta
