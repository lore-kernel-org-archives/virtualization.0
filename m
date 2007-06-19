From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH 5/5] KVM: paravirt time source
Date: Tue, 19 Jun 2007 18:04:39 +1000
Message-ID: <1182240279.19064.65.camel@localhost.localdomain>
References: <4675F462.1010708@codemonkey.ws>
	<4675F601.3090706@codemonkey.ws>	<4676D8E4.3020806@goop.org>
	<4676FEB9.6060308@codemonkey.ws>	<46770162.6030101@goop.org>
	<4677163F.2030308@codemonkey.ws>  <4677894D.3050500@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4677894D.3050500-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-06-19 at 10:44 +0300, Avi Kivity wrote:
> Anthony Liguori wrote:
> >
> >> How are you doing clockevents?
> >>   
> >>     
> >
> > Right now, I'm relying on the PIT but it would be nice to eliminate 
> > that.  I'd like to move to something PV so that I can make use of 
> > tickless guest kernels.  I'm very open to suggestion and even more open 
> > to reusing other people's code :-)
> >   
> 
> You'll need an irqchip to inject irqs.  I think Ingo's patchset had an 
> irqchip implementation.

Lguest has one in -rc4-mm2, but I'd look at Ingo's too.  Lguest's is
very much "mY fIrsT IrqchIP"...

We do tickless and it seems to work.

Cheers,
Rusty.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
