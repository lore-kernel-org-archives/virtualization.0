From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Fri, 6 Nov 2009 09:00:49 +0100
Message-ID: <200911060900.49923.borntraeger__43910.2360200652$1257494594$gmane$org@de.ibm.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<1257266319-24300-2-git-send-email-amit.shah@redhat.com>
	<200911061740.03734.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911061740.03734.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag 06 November 2009 08:10:02 schrieb Rusty Russell:
> On Wed, 4 Nov 2009 03:08:39 am Amit Shah wrote:
> > Expose multiple char devices ("ports") for simple communication
> > between the host userspace and guest.
> 
> OK, I've taken the chance to audit this patch.  I started adding patches
> until I got overwhelmed.   It's a complete mess and needs a total rewrite
>  :(

I know that Anthony disagrees, but _If we start over_, I still think we should 
use that chance and leave the old virtio console untouched and add a new driver 
for the host guest communication. IMHO it turned out that there is only a tiny 
bit of commonality. (most code pathes check for use_multiport and  then do two 
completely different things).
I like simplicity. According to David A. Wheeler's SLOCCount, the old console 
has 141 lines of code and the I truly believe that a separate guest-host comm 
vehicle would also be a lot simpler if it must not take care of the old 
virtio_console interface.

On the other hand we all should agree on one driver vs. two drivers before we go 
on. Everything else would be unfair to Amit, who had the unpleasant task to 
implement conflicting review comments....

Christian
