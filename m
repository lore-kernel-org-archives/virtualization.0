From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Thu, 06 Dec 2007 16:55:02 +0100
Message-ID: <47581B56.6020705@redhat.com>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
	<4758136D.1030002@redhat.com> <475815F1.1050902@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475815F1.1050902@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, 'Mark Williamson' <mark.williamson@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org


> Which version of the Xen tools are you using? There was a bug in the
> version released with Xen 3.1, which should have been cleaned up in the
> subsequent minor versions. Try grabbing the patch to libxc at:
> 
> http://xenbits.xensource.com/xen-3.1-testing.hg?raw-rev/135d5088909f

Probably it is this one, according to rpm version is 3.1.0, so most
likely the fix isn't there.

> Otherwise, if this doesn't work/is some other issue, could you post the
> OOPS and relevant Xen console output?

There isn't any, the mapping just doesn't work (libxc returning NULL).

thanks,
  Gerd
