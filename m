From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6 00/27] x86: PIE support and option to extend KASLR
	randomization
Date: Thu, 31 Jan 2019 16:40:38 -0500
Message-ID: <20190131214038.GI28234__26893.3920351387$1548971157$gmane$org@char.us.oracle.com>
References: <20190131192533.34130-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Garnier <thgarnie@chromium.org>
Cc: kernel-hardening@lists.openwall.com, Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@ucw.cz>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Christoph Lameter <cl@linux.com>, Rafael =?iso-8859-1?Q?=C1vila_de_Esp=EDndola?= <rafael@espindo.la>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-sparse@vger.kernel.org, xen-devel@lists.xenproject.org, Alexander Popov <alex.popov@linux.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>, Dennis Zhou <dennis@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, nixiaoming <nixiaoming@huawei.com>, Michal Marek <michal.lkml@markovi.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nick Desaulniers <ndesaulnie>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 31, 2019 at 11:24:07AM -0800, Thomas Garnier wrote:
> There has been no major concern in the latest iterations. I am interested on
> what would be the best way to slowly integrate this patchset upstream.

One question that I was somehow expected in this cover letter - what
about all those lovely speculative bugs? As in say some one hasn't
updated their machine with the Spectre v3a microcode - wouldn't they
be able to get the kernel virtual address space?

In effect rendering all this hard-work not needed?
