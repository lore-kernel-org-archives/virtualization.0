From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Tue, 03 Mar 2015 10:09:41 +0000
Message-ID: <54F5967502000078000658C8__25300.5358776592$1425378627$gmane$org@mail.emea.novell.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 03.03.15 at 10:40, <mcgrof@suse.com> wrote:
> Let's go down the rabbit hole for a bit. HAVE_ARCH_KASAN will be
> selected on x86 when:
> 
> if X86_64 && SPARSEMEM_VMEMMAP
> 
> Now Xen should not have SPARSEMEM_VMEMMAP

Why would that be?

Jan
