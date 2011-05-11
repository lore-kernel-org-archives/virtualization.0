From: Krishna Kumar2 <krkumar2@in.ibm.com>
Subject: Re: [PATCH 00/18] virtio and vhost-net performance enhancements
Date: Wed, 11 May 2011 22:40:42 +0530
Message-ID: <OF2BBEE530.9F02F495-ON6525788D.0057AC81-6525788D.005E1F24__2858.52072197503$1305133808$gmane$org@in.ibm.com>
References: <cover.1304541918.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1304541918.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> wrote on 05/05/2011 02:20:18 AM:

> [PATCH 00/18] virtio and vhost-net performance enhancements
>
> OK, here's a large patchset that implements the virtio spec update that I
> sent earlier. It supercedes the PUBLISH_USED_IDX patches
> I sent out earlier.
>
> I know it's a lot to ask but please test, and please consider for
2.6.40 :)
>
> I see nice performance improvements: one run showed going from 12
> to 18 Gbit/s host to guest with netperf, but I did not spend a lot
> of time testing performance, so no guarantees it's not a fluke,
> I hope others will try this out and report.
> Pls note I will be away from keyboard for the next week.

I tested with the git tree (which also contains the later
additional patch), and get this error on guest:

May 11 08:06:08 localhost kernel: net eth0: Unexpected TX queue failure:
-28
May 11 08:06:08 localhost kernel: net eth0: Unexpected TX queue failure:
-28
May 11 08:06:08 localhost kernel: net eth0: Unexpected TX queue failure:
-28
May 11 08:06:08 localhost kernel: net eth0: Unexpected TX queue failure:
-28
...

The network stops after that and requires a modprobe "restart" to
get it working again. This is with the new qemu/vhost/virtio-net.

Please let me know if I am missing something.

thanks,

- KK
