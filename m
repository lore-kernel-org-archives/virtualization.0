From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/4] s390: remove s390_root_dev_*()
Date: Fri, 12 Dec 2008 11:07:30 -0800
Message-ID: <20081212190730.GB2950@kroah.com>
References: <1229012203.7968.79.camel@blaa>
	<1229012216-4211-1-git-send-email-markmc@redhat.com>
	<1229012216-4211-2-git-send-email-markmc@redhat.com>
	<1229012216-4211-3-git-send-email-markmc@redhat.com>
	<1229012216-4211-4-git-send-email-markmc@redhat.com>
	<20081211180025.045b9b4a@gondolin>
	<20081212102951.01446f22@gondolin> <1229074546.4041.8.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1229074546.4041.8.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-s390@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 12, 2008 at 09:35:46AM +0000, Mark McLoughlin wrote:
> On Fri, 2008-12-12 at 10:29 +0100, Cornelia Huck wrote:
> > On Thu, 11 Dec 2008 18:00:25 +0100,
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > > On Thu, 11 Dec 2008 16:16:56 +0000,
> > > Mark McLoughlin <markmc@redhat.com> wrote:
> > > 
> > > > Replace s390_root_dev_register() with root_device_register() etc.
> > > 
> > > Nice, one more special case generalized :) I'll give it a run.
> > 
> > You missed one occurrence in iucv (see below);
> 
> Oops.
> 
> >  with that patch applied,
> > everything seems to work as expected, both for root devices created by
> > built-ins and by modules.
> 
> Thanks,
> Mark.
> 
> From: Mark McLoughlin <markmc@redhat.com>
> Subject: [PATCH] s390: remove s390_root_dev_*()
> 
> Replace s390_root_dev_register() with root_device_register() etc.

Can you resend this whole series, I see lots of replacements in this
thread and it would be good to know exactly what I should be
reviewing/applying.

thanks,

greg k-h
