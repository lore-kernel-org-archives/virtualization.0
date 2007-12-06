From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Thu, 06 Dec 2007 15:32:01 +0000
Message-ID: <475815F1.1050902@cl.cam.ac.uk>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
	<4758136D.1030002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4758136D.1030002@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, 'Mark Williamson' <mark.williamson@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Yes, except that it should actually work ;)
> 
> It doesn't for me (Fedora 8 again).  Grab xenner 0.9 (just uploaded),
> edit blkbackd.c and flip the BATCH_MAPS from 0 to 1, compile, run, see
> it not work.

Which version of the Xen tools are you using? There was a bug in the 
version released with Xen 3.1, which should have been cleaned up in the 
subsequent minor versions. Try grabbing the patch to libxc at:

http://xenbits.xensource.com/xen-3.1-testing.hg?raw-rev/135d5088909f

Otherwise, if this doesn't work/is some other issue, could you post the 
OOPS and relevant Xen console output?

Thanks,

Derek.
