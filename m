From: Zachary Amsden <zach@vmware.com>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 15:59:16 -0800
Message-ID: <45511DD4.80307@vmware.com>
References: <4550E512.1020706@goop.org> <45510672.4000301@vmware.com>
	<45510AFF.3040304@goop.org> <455117C0.2030202@vmware.com>
	<455119DB.2000704@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <455119DB.2000704@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>> Anything where you implicitly defer pagetable updates is far too =

>> vulnerable to bugs.  We played with several such schemes before, and =

>> although they could be made to work for a shadow mode hypervisor, =

>> getting them to work for both shadow and direct mode, with =

>> performance opportunities for everyone was just too risky and a =

>> burden on the Linux mm code.
>
> Yep.
>
>> There is no architectural rule about tlb flush that I am aware of, =

>> however, most cores will allow you to do NP->P transitions without a =

>> flush.  YMMV.  I believe the Linux use is fine.
>
> Hm, I was under the impression there's an actual architectural =

> guarantee there, but I don't know chapter&verse.

There isn't one explicitly stated in the book I'm looking at.  Ps 19:12 =

NIV seems relevant, although a little cryptic.

"Who can discern his errors?  Forgive my hidden faults."

> I'm working on linear pagetables, so that ptes can be allocated from =

> anywhere any be directly accessable.  This eliminates the need for =

> CONFIG_HIGHPTE, and it also simplifies a lot of the pagetable =

> walking.  Manipulating other processes's pagetables would still need =

> kmap (or a second window for cross-process pagetable manipulation), =

> but I should think that's pretty rare.

Oh, wow.  Unfortunately, the complexity isn't from how frequent or rare =

a kmapped PT access is, it is from it being there at all.

Zach
