From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 11/13] x86/paravirt: Add paravirt alternatives
	infrastructure
Date: Tue, 17 Oct 2017 11:36:57 -0400
Message-ID: <2e7890fb-3634-0f3b-003f-fc1772504b9a@oracle.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe@redhat.com>
	<3b9fd404-6912-3b58-db29-36202631b438@oracle.com>
	<20171006143259.rs3zh7k5tmsgesqy@treble>
	<5a49e43a-8d6b-512a-ec5a-641be7bae41d@oracle.com>
	<ed30216f-4b9e-2bc3-b1d2-36135b29d746@citrix.com>
	<a6c3be0b-35f4-8d23-4ea2-ead94a3fc69e@oracle.com>
	<b9fdc3ec-87cd-da0e-47b7-67cdae8ffb97@oracle.com>
	<20171017052413.nzbqniurzw7eim4b@treble>
	<de621b0b-f767-222a-e1de-aabd0e9a0bf9@oracle.com>
	<20171017143613.6i7auk3mqcqayx3o@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171017143613.6i7auk3mqcqayx3o@treble>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, live-patching@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Sasha Levin <alexander.levin@verizon.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/17/2017 10:36 AM, Josh Poimboeuf wrote:
>
> Maybe we can add a new field to the alternatives entry struct which
> specifies the offset to the CALL instruction, so apply_alternatives()
> can find it.

We'd also have to assume that the restore part of an alternative entry
is the same size as the save part. Which is true now.

-boris
