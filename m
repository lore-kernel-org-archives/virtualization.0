From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 00/27] x86: PIE support and option to extend KASLR
	randomization
Date: Fri, 1 Feb 2019 08:59:21 +1300
Message-ID: <CAGXu5jLGFd2UY89bPm_WQvcsX+RDMg0XoJvuXwfknJrGxpn4Ng__37736.7100141541$1548967285$gmane$org@mail.gmail.com>
References: <20190131192533.34130-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@ucw.cz>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Christoph Lameter <cl@linux.com>, =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>, linux-arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alexander Popov <alex.popov@linux.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>, Dennis Zhou <dennis@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, nixiaoming <nixiaoming@huawei.com>, Michal Marek <michal.lkml@markovi.>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 1, 2019 at 8:28 AM Thomas Garnier <thgarnie@chromium.org> wrote:
> These patches make the changes necessary to build the kernel as Position
> Independent Executable (PIE) on x86_64. A PIE kernel can be relocated below
> the top 2G of the virtual address space. It allows to optionally extend the
> KASLR randomization range from 1G to 3G. The chosen range is the one currently
> available, future changes will allow the kernel module to have a wider
> randomization range.

This also lays the groundwork for doing compilation-unit-granularity
KASLR, as Kristen has been working on. With PIE working, the
relocations are more sane and boot-time reordering becomes possible
(or at least, it becomes the same logically as doing the work on
modules, etc).

-- 
Kees Cook
