From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] virtio: console: control queue race fixes
Date: Mon, 09 Jan 2012 13:01:15 +1030
Message-ID: <87obuda9os.fsf@rustcorp.com.au>
References: <cover.1325845993.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1325845993.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>, miche@google.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri,  6 Jan 2012 16:19:06 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> Hello,
> 
> The first patch here fixes the race seen by Miche.  He hasn't yet
> reported back if this fixes the races he saw, but Joy Pu from Red Hat
> tested this patch with hot-plugging/unplugging ports in a loop.
> Before this patch, he saw some freezes as well as sysfs warnings.
> After applying the patch, all was well.


So, the first one should be cc: stable?

> The second patch can be folded into the series fixing S4 for
> virtio-console.  It ensures all callbacks are disabled in the freeze
> function.  This patch has a dependency on the 1st one in the sense the
> double disabling of vq won't make sense w/o patch 1.
> 
> Please review and apply.

Done, thanks.

Cheers,
Rusty.
