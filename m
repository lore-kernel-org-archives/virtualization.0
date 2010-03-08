From: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/2] virtio: console: Trivial fixes based on review
	comments
Date: Mon, 08 Mar 2010 11:34:50 +0100
Message-ID: <m3eijvrtit.fsf@trasno.mitica>
References: <1268038020-12539-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268038020-12539-1-git-send-email-amit.shah@redhat.com> (Amit
	Shah's message of "Mon, 8 Mar 2010 14:16:58 +0530")
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
Cc: virtualization@linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> wrote:
> Hello,
>
> Here are a couple of small fixes for the virtio_console code, it's mostly
> stylistic fixes.
>
> Michael, can you push these to Linus? Thanks.
>
> Amit Shah (2):
>   virtio: console: Fix type of 'len' as unsigned int
>   virtio: console: Use better variable names for fill_queue operation
>
>  drivers/char/virtio_console.c |   29 ++++++++++++++++-------------
>  1 files changed, 16 insertions(+), 13 deletions(-)

Acked-by: Juan Quintela <quintela@redhat.com>
