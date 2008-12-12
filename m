From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 4/4] s390: remove s390_root_dev_*()
Date: Fri, 12 Dec 2008 10:54:05 +0100
Message-ID: <1229075645.28887.10.camel@localhost>
References: <1229012203.7968.79.camel@blaa>
	<1229012216-4211-1-git-send-email-markmc@redhat.com>
	<1229012216-4211-2-git-send-email-markmc@redhat.com>
	<1229012216-4211-3-git-send-email-markmc@redhat.com>
	<1229012216-4211-4-git-send-email-markmc@redhat.com>
	<20081211180025.045b9b4a@gondolin> <20081212102951.01446f22@gondolin>
	<1229074546.4041.8.camel@blaa>  <1229075116.28887.4.camel@localhost>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1229075116.28887.4.camel@localhost>
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
Cc: linux-s390@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-12-12 at 10:45 +0100, Martin Schwidefsky wrote:
> On Fri, 2008-12-12 at 09:35 +0000, Mark McLoughlin wrote:
> > From: Mark McLoughlin <markmc@redhat.com>
> > Subject: [PATCH] s390: remove s390_root_dev_*()
> > 
> > Replace s390_root_dev_register() with root_device_register() etc.
> > 
> > [Includes fix from Cornelia Huck]
> > 
> > Signed-off-by: Mark McLoughlin <markmc@redhat.com>
> 
> I can carry the patch in my patch queue. Thanks.

Oops, this depends on another patch. If the other patch is missing it
doesn't compile.. So I better not add that patch to my queue. It should
be sent together with the patch it depends on.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
