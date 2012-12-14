From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio-spec: Document VIRTIO_BLK_T_GET_ID.
Date: Fri, 14 Dec 2012 11:23:49 +0100
Message-ID: <CAJSP0QUEwmd3ZPpzPFO6AN+gqUqD4bCfZwyTo0StwQzoB7+VgA@mail.gmail.com>
References: <1355317877-22426-1-git-send-email-alexey.zaytsev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1355317877-22426-1-git-send-email-alexey.zaytsev@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 12, 2012 at 2:11 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
> ---
>
> Hi.
>
> This feature has been around for a couple of years, probably time to document it.
> Lyx cleaned up some lines I did not touch, is this ok?

Please manually remove those hunks from the patch.  If Lyx will do
this every time it edits the file then these line break changes can be
done in a separate commit just to clean up the Lyx source.

>  virtio-spec.lyx |   73 ++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 56 insertions(+), 17 deletions(-)

Otherwise looks good.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
