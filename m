From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver (V2)
Date: Wed, 18 Nov 2009 16:56:30 +0000
Message-ID: <20091118165630.GB28723__23263.126347638$1258563460$gmane$org@shareable.org>
References: <1258488996.2820.35.camel@aglitke>
	<1258490189.2820.37.camel@aglitke>
	<200911181200.39971.rusty@rustcorp.com.au>
	<4B040C82.6070901@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Rusty Russell wrote:
> >The little-endian conversion of the balloon driver is a historical mistake
> >(no other driver does this).  Let's not extend it to the stats.
> 
> I think the mistake is that the other drivers don't do that.
> 
> We cheat in qemu and assume that the guest is always in a fixed 
> endianness but this is not always the case for all architectures.

If guests can have different endianness (reasonable on some CPUs where
it's switchable - some even have more than 2 options), then I guess
the *host* on those systems have different endianness too.

Is the host's endianness signalled to the guest anywhere, so that
guest drivers can do cpu_to_qemuhost32(), when someone eventually
finds that necessary?

-- Jamie
