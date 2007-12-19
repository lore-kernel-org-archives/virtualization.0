From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH] finish processor.h integration
Date: Wed, 19 Dec 2007 10:15:26 -0200
Message-ID: <5d6222a80712190415q7921b244ua073a8c64ab30597__20480.6367088624$1198066675$gmane$org@mail.gmail.com>
References: <1198008293639-git-send-email-gcosta@redhat.com>
	<20071219101736.GC3521@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071219101736.GC3521@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Dec 19, 2007 8:17 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Glauber de Oliveira Costa <gcosta@redhat.com> wrote:
>
> > What's left in processor_32.h and processor_64.h cannot be cleanly
> > integrated. However, it's just a couple of definitions. They are moved
> > to processor.h around ifdefs, and the original files are deleted. Note
> > that there's much less headers included in the final version.
>
> hm, doesnt apply;
>
>  Applying patch patches/x86-finish-processor-h-integration.patch
>  patching file include/asm-x86/processor.h
>  Hunk #2 FAILED at 287.
>  Hunk #3 FAILED at 311.
>  Hunk #4 succeeded at 786 (offset -8 lines).
>  2 out of 4 hunks FAILED -- rejects in file include/asm-x86/processor.h
>
> i fixed it up by hand - the result is below - does it look OK to you?
> (Also, could you check latest x86.git whether i've picked up all your
> patches correctly - the reject might be indicative of some missing
> pieces.)

Your fix is okay. The other patches seems to be all there. The reason
for this is that
it conflicts with Roland's (welcome) i387 patches.


-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
