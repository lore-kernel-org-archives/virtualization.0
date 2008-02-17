From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/5] Make vsmp a paravirt client
Date: Sun, 17 Feb 2008 19:03:50 +0100
Message-ID: <20080217180349.GU6006__3469.97854435376$1203271599$gmane$org@elte.hu>
References: <1202756982-18244-1-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1202756982-18244-1-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, shai@scalemp.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber Costa <gcosta@redhat.com> wrote:

> This series of five patches turns the vsmp architecture support in 
> x86_64 into a paravirt client. If PARAVIRT is on, the probe function 
> vsmp_init() is run unconditionally, patching the necessary irq 
> functions accordingly if running ontop of such box.

thanks Glauber, applied. I'll reply with a few minor comments to the 
patches themselves.

	Ingo
