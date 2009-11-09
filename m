From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Mon, 9 Nov 2009 17:39:26 +0530
Message-ID: <20091109120926.GB11256@amit-x200.redhat.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<1257266319-24300-2-git-send-email-amit.shah@redhat.com>
	<200911060843.05934.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911060843.05934.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) Nov 06 2009 [08:43:05], Christian Borntraeger wrote:
> Am Dienstag 03 November 2009 17:38:39 schrieb Amit Shah:
> 
> > drivers/char/Kconfig           |    6 +
> > drivers/char/virtio_console.c  | 1412 ++++++++++++++++++++++++++++++++++++----
> > include/linux/virtio_console.h |   50 ++-
> > 3 files changed, 1332 insertions(+), 136 deletions(-)
> 
> I have not looked at your last two versions of the patch  since you did not add 
> a changelog to your patch description. I thought you only did minor changes.
> Turned out you added/changed several places. (e.g. VIRTIO_CONSOLE_CACHE_BUFFERS, 
> VIRTIO_CONSOLE_THROTTLE_PORT  and VIRTIO_CONSOLE_BUFFER_LIMIT  are all new)

I see v8 slipped out without a changelog; sorry for that. v9, v10 had
the changelogs but v8 had included the caching and throttling support.

		Amit
