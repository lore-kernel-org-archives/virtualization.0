From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4] Add virtio-input driver.
Date: Thu, 26 Mar 2015 12:23:16 +1030
Message-ID: <87oangh6cz.fsf__10289.1429829926$1427335629$gmane$org@rustcorp.com.au>
References: <1427198927-1745-1-git-send-email-kraxel@redhat.com>
	<877fu5iwxk.fsf@rustcorp.com.au> <20150325053613.GA4572@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150325053613.GA4572@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vojtech Pavlik <vojtech@suse.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, "open list:ABI/API" <linux-api@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Herrmann <dh.herrmann@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Vojtech Pavlik <vojtech@suse.com> writes:
> On Wed, Mar 25, 2015 at 01:51:43PM +1030, Rusty Russell wrote:
>> Imagine a future virtio standard which incorporates this.  And a Windows
>> or FreeBSD implementation of the device and or driver.  How ugly would
>> they be?
>
> A windows translation layer is fairly easy, people porting software from
> Windows to Linux told me numerous times that adapting isn't hard. I also
> believe that at least one of the BSD's has a compatible implementation
> these days based on the fact that I was asked to allow copying the
> headers in the past.

Thanks Vojtech, that answers my questions.

I figure we apply this and see where it leads...

Cheers,
Rusty.
