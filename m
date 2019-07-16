From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Tue, 16 Jul 2019 06:15:30 +0200
Message-ID: <49462c78-f0ad-cb18-7cc7-2a3ce20c7006__1460.1278396853$1563250543$gmane$org@suse.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190715151641.29210-1-andrew.cooper3@citrix.com>
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
Cc: FengTang <feng.tang@intel.com>, PavelMachek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephane Eranian <eranian@google.com>, virtualization@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 15.07.19 17:16, Andrew Cooper wrote:
> There is a lot of infrastructure for functionality which is used
> exclusively in __{save,restore}_processor_state() on the suspend/resume
> path.
> 
> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored by
> lapic_{suspend,resume}().  Saving and restoring cr8 independently of the
> rest of the Local APIC state isn't a clever thing to be doing.
> 
> Delete the suspend/resume cr8 handling, which shrinks the size of struct
> saved_context, and allows for the removal of both PVOPS.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
