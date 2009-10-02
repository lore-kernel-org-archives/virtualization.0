From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: INFO: task journal:337 blocked for more than 120 seconds
Date: Fri, 02 Oct 2009 11:30:47 -0700
Message-ID: <4AC646D7.5030709__8592.85752890191$1254508470$gmane$org@goop.org>
References: <1254345112.8837.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254345112.8837.9.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shirley Ma <mashirle@us.ibm.com>
Cc: Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Kevin Bowling <kevinb@analograils.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/30/09 14:11, Shirley Ma wrote:
> Anybody found this problem before? I kept hitting this issue for 2.6.31
> guest kernel even with a simple network test.
>
> INFO: task kjournal:337 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_sec" disables this message.
>
> kjournald	D 00000041	0	337	2 0x00000000
>
> My test is totally being blocked.

I'm assuming from the lists you've posted to that this is under KVM? 
What disk drivers are you using (virtio or emulated)?

Can you get a full stack backtrace of kjournald?

Kevin Bowling submitted a RH bug against Xen with apparently the same
symptoms (https://bugzilla.redhat.com/show_bug.cgi?id=526627).  I'm
wondering if there's a core kernel bug here, which is perhaps more
easily triggered by the changed timing in a virtual machine.

Thanks,
    J
