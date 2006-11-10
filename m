From: Andrew Morton <akpm@osdl.org>
Subject: Re: Paravirt-ops next steps
Date: Thu, 9 Nov 2006 19:37:44 -0800
Message-ID: <20061109193744.94d7afa2.akpm@osdl.org>
References: <4553F1A2.2050802@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4553F1A2.2050802@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty@smtp.osdl.org, Jeremy@smtp.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 09 Nov 2006 19:27:30 -0800
Zachary Amsden <zach@vmware.com> wrote:

> So it's gotten a bit confusing to figure out how we should go about =

> upstreaming the rest of our patches.  Our patchkit in the paravirt-ops =

> tree currently applies to 2.6.19-rc4-mm2, but there are a number of =

> conflicts that got resolved when merging into Andi's i386 tree.
> =

> What is the best way to sanitize the remaining patches so they smoothly =

> integrate into the appropriate trees?  Should we rebase to Andi's tree, =

> resync to -rc5-mm1, or just cross our fingers and fix up rejects as they =

> occur?
> =

> Right now I'm working on getting the timer code for VMI fixed up, and it =

> requires several hooks in the timer infrastructure and possibly the APIC =

> infrastructure that has been changed a lot recently by Thomas Gleixner's =

> patches - I don't see any obvious conflicts, and the new code looks =

> better, but it would be comforting to know I am baking changes against =

> the right tree.
> =


It'd be better to develop and test this work on top of Thomas's stuff, as
that's what 2.6.20 will doubtless look like.  That means working against
-mm.  Once Thomas's patches are in mainline then the patches will apply to
Andi's tree too and I can send them over to him.

That way, the patch-applying-order equals mainstream-merging-order equals
chronological-writing-order, which is generally a good thing.
