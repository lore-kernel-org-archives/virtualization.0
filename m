From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 32/32] virtio: console: show error message if hvc_alloc
	fails for console ports
Date: Wed, 20 Jan 2010 18:50:55 +1030
Message-ID: <201001201850.56114.rusty@rustcorp.com.au>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<201001191152.52445.rusty@rustcorp.com.au>
	<20100119170627.GE27165@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100119170627.GE27165@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Jan 2010 03:36:27 am Amit Shah wrote:
> On (Tue) Jan 19 2010 [11:52:50], Rusty Russell wrote:
> > On Tue, 19 Jan 2010 12:15:26 am Amit Shah wrote:
> > > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > 
> > These all look great!  I'm not entirely convinced about the host throttling,
> > but it's harmless to have.
> 
> I'll rip out the throttling feature -- and ensure write(2) returns only
> when the host acks the data.
> 
> The changes will touch 3 patches in the series -- do you want me to
> resend those 3 patches, or new patches on top of my series, or send a new
> series altogether?

Replacements for those will be fine.

Thanks!
Rusty.
