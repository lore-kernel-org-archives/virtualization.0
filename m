From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4] Add virtio-input driver.
Date: Wed, 25 Mar 2015 13:51:43 +1030
Message-ID: <877fu5iwxk.fsf__12173.8223395825$1427256646$gmane$org@rustcorp.com.au>
References: <1427198927-1745-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427198927-1745-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: mst@redhat.com, "open list:ABI/API" <linux-api@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>, David Herrmann <dh.herrmann@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann <kraxel@redhat.com> writes:
> virtio-input is basically evdev-events-over-virtio, so this driver isn't
> much more than reading configuration from config space and forwarding
> incoming events to the linux input layer.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Is the input layer sane?  I've never dealt with it, so I don't know.

What's it used for?

Imagine a future virtio standard which incorporates this.  And a Windows
or FreeBSD implementation of the device and or driver.  How ugly would
they be?

Thanks,
Rusty.
