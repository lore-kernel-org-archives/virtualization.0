From: "ron minnich" <rminnich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 14:27:53 -0700
Message-ID: <13426df10706201427x257166bakf08d60276fdbbaff@mail.gmail.com>
References: <4675F462.1010708@codemonkey.ws> <46787325.30804@vmware.com>
	<4679381E.9090404@codemonkey.ws> <46794899.6070708@goop.org>
	<46798174.2060304@vmware.com> <46798597.4020903@codemonkey.ws>
	<4679882B.7070605@vmware.com> <46798C99.8010303@codemonkey.ws>
	<46799001.5020807@vmware.com> <46799716.9040402@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46799716.9040402-TSDbQ3PG+2Y@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Cc: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On 6/20/07, Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org> wrote:


> I'm not wildly happy about the idea of using PCI for probing for
> otherwise completely non-PCI devices,

Good :-)

>Xen deals with it with Xenbus, but I
> figure I'm unlikely to convince everyone to adopt that.

Especially those of us who have used it Xenbus :-)

> Yes.  That's the thinking behind using PCI as a somewhat common
> mechanism for device discovery.  s390 folks hate it, of course.

My fear with using PCI is that it is a short-term remedy that we might
find ourselves locked into once we start, and there are lots of things
that will not fit into the PCI model. So we would have picked a
short-term, expedient approach that works for simple cases that breaks
interesting uses.

It's happened in other projects ...

thanks

ron

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
