From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 01/13] x86/paravirt: remove wbinvd() paravirt interface
Date: Tue, 24 Oct 2017 15:17:14 +0200
Message-ID: <7f7dbb34-100e-13ae-2dff-e04db33ab1bf__14338.7971249924$1508851068$gmane$org@suse.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<3f9bf17f6372ee92d984f6c7fd13e0cb14bc0e0a.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3f9bf17f6372ee92d984f6c7fd13e0cb14bc0e0a.1507128293.git.jpoimboe@redhat.com>
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
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 04/10/17 17:58, Josh Poimboeuf wrote:
> Since lguest was removed, only the native version of wbinvd() is used.
> The paravirt interface is no longer needed.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
