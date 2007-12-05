From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 15:12:21 +0100
Message-ID: <4756B1C5.8070003@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>	
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>	
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>	
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
	<4755B158.3030008@redhat.com> <47569014.8080008@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <47569014.8080008@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> Thanks for the repro details. I'll have a go at this later. One thing we
> haven't tested AFAIK is mapping grants in the same domain: could you
> check to see if the bug is the same if you attach a block device to a
> domain other than Dom0? Also, could you send any Xen console output, if
> it contains errors or warnings?

Attaching to another domain works better.  blkbackd needs some fixes as
well though ...

cheers,
  Gerd
