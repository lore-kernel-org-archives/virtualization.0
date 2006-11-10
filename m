From: Zachary Amsden <zach@vmware.com>
Subject: Paravirt-ops next steps
Date: Thu, 09 Nov 2006 19:27:30 -0800
Message-ID: <4553F1A2.2050802@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

So it's gotten a bit confusing to figure out how we should go about =

upstreaming the rest of our patches.  Our patchkit in the paravirt-ops =

tree currently applies to 2.6.19-rc4-mm2, but there are a number of =

conflicts that got resolved when merging into Andi's i386 tree.

What is the best way to sanitize the remaining patches so they smoothly =

integrate into the appropriate trees?  Should we rebase to Andi's tree, =

resync to -rc5-mm1, or just cross our fingers and fix up rejects as they =

occur?

Right now I'm working on getting the timer code for VMI fixed up, and it =

requires several hooks in the timer infrastructure and possibly the APIC =

infrastructure that has been changed a lot recently by Thomas Gleixner's =

patches - I don't see any obvious conflicts, and the new code looks =

better, but it would be comforting to know I am baking changes against =

the right tree.

Zach
