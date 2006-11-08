From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Wed, 08 Nov 2006 12:18:13 -0800
Message-ID: <45523B85.1080004@goop.org>
References: <C1774713.3FA7%Keir.Fraser@cl.cam.ac.uk>
	<4552371C.8050901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4552371C.8050901@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Do you mean the tlb entry gets invalidated as part of raising the =

> fault?
>   =


Specifically, does it simply invalidate the TLB at that point, or does =

it re-walk the page table and populate it with the new PTE?

    J
