From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/5] x86: Convert some slow-path static_cpu_has() callers
	to boot_cpu_has()
Date: Sat, 30 Mar 2019 13:50:48 +0100
Message-ID: <9b1c18da-d337-7c9d-52fe-854375eb8d55__29188.3423853264$1553950297$gmane$org@suse.com>
References: <20190330112022.28888-1-bp@alien8.de>
	<20190330112022.28888-3-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190330112022.28888-3-bp@alien8.de>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dominik Brodowski <linux@dominikbrodowski.net>, virtualization@lists.linux-foundation.org, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <nadav.amit@gmail.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>, Jann Horn <jannh@google.com>, Aubrey Li <aubrey.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Masami Hiramatsu <mhiramat@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 30/03/2019 12:20, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Using static_cpu_has() is pointless on those paths, convert them to the
> boot_cpu_has() variant.
> 
> No functional changes.
> 
> Reported-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>

For the paravirt part: Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
