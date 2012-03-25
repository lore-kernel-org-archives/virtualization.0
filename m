From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: vhost question
Date: Sun, 25 Mar 2012 17:18:28 +0100
Message-ID: <CAJSP0QXEJeaWgDrGXYAUu0W6skwO10Nhtfx9yaVxd9shAq1OLQ__26589.2020347112$1332757356$gmane$org@mail.gmail.com>
References: <4F6A84EF.9060105@gmail.com>
	<CAJSP0QXKahPja7S68MC0vLZR7HNxG4hLPRYEFH536QbP1fSu7w@mail.gmail.com>
	<CADC0ay0ZRL79uMq72kAewOBTMCgMe1_1BLotdH9QnOwosJkTYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADC0ay0ZRL79uMq72kAewOBTMCgMe1_1BLotdH9QnOwosJkTYQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steve Glass <stevie.glass@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 25, 2012 at 1:29 PM, Steve Glass <stevie.glass@gmail.com> wrote:
> On 22 March 2012 19:52, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>>
>> Can you queue a tx->rx kick on the vhost work queue with
>> vhost_work_queue()?
>>
>> Stefan
>
>
> I've been looking at this and trying to work out how to achieve that. I can
> see how I can enqueue some work on the vhost queue but the rx_handler needs
> to run in the process context of the receiving VM (or else it can't access
> the ring). I don't think that's true of the work queue (doesn't it run with
> the qemu process context?)

The vhost worker thread has the mm of the process, see use_mm(dev->mm)
in drivers/vhost/vhost.c:vhost_worker().  It sounds like you need
vhost worker A (tx) to schedule work for vhost worker B (rx).

Stefan
