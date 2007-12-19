From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] finish processor.h integration
Date: Wed, 19 Dec 2007 14:45:46 +0100
Message-ID: <20071219134546.GA21282__13784.1809927069$1198072391$gmane$org@elte.hu>
References: <1198008293639-git-send-email-gcosta@redhat.com>
	<20071219101736.GC3521@elte.hu>
	<5d6222a80712190415q7921b244ua073a8c64ab30597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d6222a80712190415q7921b244ua073a8c64ab30597@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <glommer@gmail.com> wrote:

> > i fixed it up by hand - the result is below - does it look OK to 
> > you? (Also, could you check latest x86.git whether i've picked up 
> > all your patches correctly - the reject might be indicative of some 
> > missing pieces.)
> 
> Your fix is okay. The other patches seems to be all there. The reason 
> for this is that it conflicts with Roland's (welcome) i387 patches.

ah, indeed - i forgot about that interaction. Your patches passed a
few hundred random builds and bootups meanwhile so i think they are
now 100% Perfect (tm) :-)

	Ingo
