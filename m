From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Thu, 09 Nov 2006 08:29:03 +0000
Message-ID: <C178974F.4076%Keir.Fraser@cl.cam.ac.uk>
References: <45526781.9000909@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45526781.9000909@goop.org>
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

On 8/11/06 11:25 pm, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> Keir Fraser wrote:
>> Another
>> factoid I discovered at the same meeting is that the CPU may cache parti=
al
>> page walks. So, for example, just because you 'detach' a page table from=
 a
>> page-directory entry, doesn't mean that page table won't be accessed on
>> future hardware TLB fills.
>>   =

> =

> Do you know if these intermediate TLB entries are level-sensitive?  Ie,
> if you have a linear pagetable mapping where the pagetable points back
> to itself, will that result in multiple TLB entries for the pmd pages
> (pmd as pmd, and pmd as pte)?

I think so. I can't think why the CPU would bother to disallow this. It does
mean you have to be careful when changing page-directory entries that your
linear mapping (if you have one) doesn't go stale.

 -- Keir
