From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 14:22:15 +0000
Message-ID: <C37C6497.196D6%Keir.Fraser@cl.cam.ac.uk>
References: <4756B1C5.8070003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4756B1C5.8070003@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Gerd Hoffmann <kraxel@redhat.com>, Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On 5/12/07 14:12, "Gerd Hoffmann" <kraxel@redhat.com> wrote:

>> Thanks for the repro details. I'll have a go at this later. One thing we
>> haven't tested AFAIK is mapping grants in the same domain: could you
>> check to see if the bug is the same if you attach a block device to a
>> domain other than Dom0? Also, could you send any Xen console output, if
>> it contains errors or warnings?
> 
> Attaching to another domain works better.  blkbackd needs some fixes as
> well though ...

Is this patch to go into linux-2.6.18-xen.hg then?

It needs a signed-off-by line if so.

 -- Keir
