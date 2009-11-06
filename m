From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Fri, 6 Nov 2009 08:43:05 +0100
Message-ID: <200911060843.05934.borntraeger__11377.5913873271$1257493594$gmane$org@de.ibm.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<1257266319-24300-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257266319-24300-2-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 03 November 2009 17:38:39 schrieb Amit Shah:

> drivers/char/Kconfig           |    6 +
> drivers/char/virtio_console.c  | 1412 ++++++++++++++++++++++++++++++++++++----
> include/linux/virtio_console.h |   50 ++-
> 3 files changed, 1332 insertions(+), 136 deletions(-)

I have not looked at your last two versions of the patch  since you did not add 
a changelog to your patch description. I thought you only did minor changes.
Turned out you added/changed several places. (e.g. VIRTIO_CONSOLE_CACHE_BUFFERS, 
VIRTIO_CONSOLE_THROTTLE_PORT  and VIRTIO_CONSOLE_BUFFER_LIMIT  are all new)

When you do bigger changes can you add a changelog in your patch description in 
the future?
