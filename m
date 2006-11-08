From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Wed, 08 Nov 2006 15:25:53 -0800
Message-ID: <45526781.9000909@goop.org>
References: <C17815FB.403A%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <C17815FB.403A%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> Another
> factoid I discovered at the same meeting is that the CPU may cache partial
> page walks. So, for example, just because you 'detach' a page table from a
> page-directory entry, doesn't mean that page table won't be accessed on
> future hardware TLB fills.
>   =


Do you know if these intermediate TLB entries are level-sensitive?  Ie, =

if you have a linear pagetable mapping where the pagetable points back =

to itself, will that result in multiple TLB entries for the pmd pages =

(pmd as pmd, and pmd as pte)?

    J
