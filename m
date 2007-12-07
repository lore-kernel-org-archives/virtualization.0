From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/3] Unify segment headers
Date: Fri, 7 Dec 2007 21:41:02 +0100
Message-ID: <20071207204102.GA25424__12674.2678847679$1197060304$gmane$org@elte.hu>
References: <119704456265-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <119704456265-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> Hi,
> 
> In this patch, I unify segment_32.h and segment_64.h into segment.h 
> They have some common parts, but a considerable ammount of code still 
> has to be around ifdefs.
> 
> The only patch that is really important to paravirt is the first one, 
> that moves a paravirt definition into the common header. The other two 
> are just normal integration, and pretty much independent

thanks, i've picked them up for x86.git.

	Ingo
