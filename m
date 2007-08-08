From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 21/25] [PATCH] export cpu_gdt_descr
Date: Wed, 8 Aug 2007 11:24:41 -0300
Message-ID: <5d6222a80708080724i67117252y95ac5443c46160d3__47839.883741881$1186583434$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468043920-git-send-email-gcosta@redhat.com>
	<118654680831-git-send-email-gcosta@redhat.com>
	<11865468122642-git-send-email-gcosta@redhat.com>
	<11865468162812-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
	<11865468321629-git-send-email-gcosta@redhat.com>
	<11865468362401-git-send-email-gcosta@redhat.com>
	<1186572745.2862.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186572745.2862.5.camel@laptopd505.fenrus.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/8/07, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2007-08-08 at 01:19 -0300, Glauber de Oliveira Costa wrote:
> > With paravirualization, hypervisors needs to handle the gdt,
> > that was right to this point only used at very early
> > inialization code. Hypervisors are commonly modules, so make
> > it an export
> >
>
> the GDT is so deeply internal that this really ought to be a _GPL
> export..

Yes, Arjan, I agree. Thanks for noticing it.


-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
