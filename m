From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v5] Add virtio-input driver.
Date: Fri, 27 Mar 2015 13:26:29 +1030
Message-ID: <87lhijqhb6.fsf__8749.49267968095$1427426026$gmane$org@rustcorp.com.au>
References: <1427366965-32549-1-git-send-email-kraxel@redhat.com>
	<20150326130644-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150326130644-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Denys Vlasenko <dvlasenk@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Herrmann <dh.herrmann@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Mar 26, 2015 at 11:49:25AM +0100, Gerd Hoffmann wrote:
>> virtio-input is basically evdev-events-over-virtio, so this driver isn't
>> much more than reading configuration from config space and forwarding
>> incoming events to the linux input layer.
>> 
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Still a bit worried about using input.h as host/guest
> interface (can't we use some formal standard, e.g. USB HID?),
> but I'll let Rusty decide that.

I like the simplicity, and this API is pretty well proven.

Since this is under drivers/virtio rather than drivers/input, I've
applied it to my tree.

I have a dream where Denys Vlasenko adds this and the virtio gl device
to lguest, and we have X running under lguest :)

Applied!
Rusty.
