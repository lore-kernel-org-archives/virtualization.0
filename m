From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 11:15:05 +0100
Message-ID: <45ED3F29.6000705@suse.de>
References: <1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de>
	<20070306093436.GA30239@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306093436.GA30239@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Gerd Hoffmann <kraxel@suse.de> wrote:
> =

>> Oh, and btw: What was the reason why kvm paravirtualization doesn't =

>> use the vmi interface?
> =

> cleanliness and performance: KVM doesnt need any artificial indirection.

Xen doesn't need it either.

> IMO the GPL-ed ROM portion of VMI was a bad idea to begin with.

So why do you want xen use vmi then?

> well, the VMI patches got into Linux with the claim that it's also =

> useful for Xen. So that claim was ... not actually true?

As mentioned there was a proof-of-concept VMI ROM done by vmware.  As
far I know it translated the VMI ROM interface calls into xen hypercalls
somehow, Zach probably has more details.

So in the end you would still have two different hypervisor ABI's, the
VMI ROM just hides that.

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
