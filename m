From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 7/7] virtio: console: Return -EPIPE if port on the host
	isn't connected
Date: Tue, 23 Mar 2010 11:46:54 +0100
Message-ID: <4BA89C1E.7090403@redhat.com>
References: <1269334680-1369-1-git-send-email-amit.shah@redhat.com>	<1269334680-1369-2-git-send-email-amit.shah@redhat.com>	<1269334680-1369-3-git-send-email-amit.shah@redhat.com>	<1269334680-1369-4-git-send-email-amit.shah@redhat.com>	<1269334680-1369-5-git-send-email-amit.shah@redhat.com>	<1269334680-1369-6-git-send-email-amit.shah@redhat.com>	<1269334680-1369-7-git-send-email-amit.shah@redhat.com>	<1269334680-1369-8-git-send-email-amit.shah@redhat.com>	<20100323090023.GD22774@redhat.com>
	<20100323091352.GI8675@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100323091352.GI8675@amit-x200.redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/23/10 10:13, Amit Shah wrote:
>>> +	if (use_multiport(port->portdev)&&  !port->host_connected)
>>> +		return -EPIPE;
>>> +
>>
>> Hmm, do applications actually handle this error?
>
> Don't know; there aren't any apps yet that use this functionality too.

Looks sensible to me.

> However, some error has to be indicated to the app otherwise it's just
> messy if the app keeps writing and receiving EAGAIN; we just get a tight
> loop in this case.

With poll support done right (don't signal "writable" when not 
connected) this shouldn't be a issue.  Apps retrying over and over 
without waiting for the filehandle becoming writable are broken by design.

But apps can't disturgish between "ring full" and "host disconnected" 
then.  So think returning -EPIPE here isn't a bad choice.

cheers,
   Gerd
