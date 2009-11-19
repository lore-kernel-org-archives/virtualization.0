From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver (V2)
Date: Thu, 19 Nov 2009 11:06:38 +1030
Message-ID: <200911191106.38976.rusty__47605.8043809191$1258591057$gmane$org@rustcorp.com.au>
References: <1258488996.2820.35.camel@aglitke>
	<200911181200.39971.rusty@rustcorp.com.au>
	<4B040C82.6070901@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B040C82.6070901@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: qemu-devel@nongnu.org, Avi Kivity <avi@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 19 Nov 2009 01:32:26 am Anthony Liguori wrote:
> Rusty Russell wrote:
> > The little-endian conversion of the balloon driver is a historical mistake
> > (no other driver does this).  Let's not extend it to the stats.
> 
> I think the mistake is that the other drivers don't do that.
> 
> We cheat in qemu and assume that the guest is always in a fixed 
> endianness but this is not always the case for all architectures.

Perhaps, but it's documented in the spec.  My assertion remains that to do
any virtualization you need to know what the guest endian is anyway, so
endian converts throughout the drivers just add pain for driver authors.

> I think making the interface u64 and byte based would be the best 
> solution.  Making assumptions about page size across guest and host is 
> another thing we should try to avoid.

Yep, just report the raw byte counts as u64.

Cheers,
Rusty.
