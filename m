From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Mon, 15 Jul 2019 15:22:57 +0200
Message-ID: <a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
References: <20190715130056.10627-1-andrew.cooper3@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190715130056.10627-1-andrew.cooper3@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>, LKML <linux-kernel@vger.kernel.org>
Cc: FengTang <feng.tang@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J.Wysocki" <rjw@rjwysocki.net>, Stephane Eranian <eranian@google.com>, virtualization@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 15.07.19 15:00, Andrew Cooper wrote:
> There is a lot of infrastructure for functionality which is used
> exclusively in __{save,restore}_processor_state() on the suspend/resume
> path.
> 
> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
> independently by lapic_{suspend,resume}().

Aren't those called only with CONFIG_PM set?


Juergen
