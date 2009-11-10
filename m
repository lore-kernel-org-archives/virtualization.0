From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver
Date: Tue, 10 Nov 2009 15:52:42 -0600
Message-ID: <4AF9E0AA.8040100__13369.5334232927$1257890039$gmane$org@us.ibm.com>
References: <1257782838.2835.5.camel@aglitke>
	<1257784326.2835.16.camel@aglitke>
	<200911101312.02650.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911101312.02650.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, agl@linux.vnet.ibm.com, qemu-devel@nongnu.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tue, 10 Nov 2009 03:02:06 am Adam Litke wrote:
>   
>> A simpler approach is to collect memory statistics in the virtio
>> balloon driver and communicate them to the host via the device config space.
>>     
>
> There are two issues I see with this.  First, there's an atomicity problem
> since you can't tell when the stats are consistent.  Second, polling is
> ugly.
>
> A stats vq might solve this more cleanly?
>   

This turns out to not work so nicely.  You really need bidirectional 
communication.  You need to request that stats be collected and then you 
need to tell the hypervisor about the stats that were collected.  You 
don't need any real correlation between requests and stat reports either.

This really models how target/actual work and I think it suggests that 
we want to reuse that mechanism for the stats too.

> Rusty.
>   


-- 
Regards,

Anthony Liguori
