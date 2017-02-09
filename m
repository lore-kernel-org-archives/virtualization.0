From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/2] hyperv: implement hv_get_tsc_page()
Date: Thu, 9 Feb 2017 15:17:29 -0800
Message-ID: <20170209151729.6c88b779__562.072048387741$1486682264$gmane$org@xeon-e3>
References: <20170209141052.18694-1-vkuznets@redhat.com>
	<20170209141052.18694-2-vkuznets@redhat.com>
	<BLUPR0301MB20981399653ED5166E0C4435CC450@BLUPR0301MB2098.namprd03.prod.outlook.com>
	<alpine.DEB.2.20.1702092112340.4500@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1702092112340.4500@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 9 Feb 2017 21:14:25 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 9 Feb 2017, Stephen Hemminger wrote:
> 
> > The actual code looks fine, but the style police will not like you.
> > { should be at start of line on functions.
> > And #else should be at start of line,
> > 
> > But maybe this was just more of exchange mangling the mail.  
> 
> Looks like.
> 
> > +struct ms_hyperv_tsc_page *hv_get_tsc_page(void) {
> > +	return tsc_pg;
> > +}
> > +  
> 
> That's how it reads in a proper mail client connected to a proper mail
> server:
> 
> > +struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> > +{
> > +       return tsc_pg;
> > +}  
> 
> :)


Yup. it looks like the mail server is trying to be "helpful" by eliminating extra white space.
