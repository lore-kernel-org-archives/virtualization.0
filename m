From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH 2/2] remoteproc: Add support for host virtio rings (vringh)
Date: Fri, 5 Apr 2013 08:15:27 +0200
Message-ID: <CAJK669b8KzyT3AbN7Lw66DL5ANreiqnqjDnnRotO2Qh150rvXw@mail.gmail.com>
References: <1363339796-14591-1-git-send-email-erwan.yvin@stericsson.com>
	<1363339796-14591-3-git-send-email-erwan.yvin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363339796-14591-3-git-send-email-erwan.yvin@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Erwan Yvin <erwan.yvin@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, lkml <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russel <rusty@ruscorp.com.au>, Ido Yariv <ido@wizery.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Ohad,

On Fri, Mar 15, 2013 at 10:29 AM, Erwan Yvin <erwan.yvin@stericsson.com> wrote:
> From: Erwan Yvin <erwan.yvin@stericsson.com>
>
> Implement the vringh callback functions in order
> to manage host virtio rings and handle kicks.
> This allows virtio device to request host-virtio-rings.
>
> Signed-off-by: Erwan Yvin <erwan.yvin@stericsson.com>

Any chance that you could review this in time for 3.10 merge window?
This is the last missing piece for host vring support.

The patches would have to be Acked/Reviewed by and should go via
Rusty's tree.

Thanks,
Sjur
