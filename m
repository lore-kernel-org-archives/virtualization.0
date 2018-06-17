From: Mike Galbraith <efault@gmx.de>
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected  to 9428088c90b6
	("drm/qxl: reapply cursor after resetting primary")
Date: Sun, 17 Jun 2018 12:38:06 +0200
Message-ID: <1529231886.5303.6.camel__15523.6900704496$1529231775$gmane$org@gmx.de>
References: <1529163551.16103.16.camel@gmx.de>
	<20180617093607.GA27652@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180617093607.GA27652@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ray Strode <rstrode@redhat.com>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2018-06-17 at 11:36 +0200, Greg KH wrote:
> 
> And if you revert that patch, does everything work again?

Yes.

	-Mike
