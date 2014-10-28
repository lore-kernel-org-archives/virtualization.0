From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_blk: fix race at module removal
Date: Tue, 28 Oct 2014 10:55:04 +1030
Message-ID: <8761f5avmn.fsf@rustcorp.com.au>
References: <1414080703-4547-1-git-send-email-mst@redhat.com>
	<CACVXFVMP9yLfUhwh6MH=q6a11Z8AeJ8aso7R+LNb-QoDfD5UVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACVXFVMP9yLfUhwh6MH=q6a11Z8AeJ8aso7R+LNb-QoDfD5UVw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ming Lei <tom.leiming@gmail.com> writes:
> On Fri, Oct 24, 2014 at 12:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> If a device appears while module is being removed,
>> driver will get a callback after we've given up
>> on the major number.
>>
>> In theory this means this major number can get reused
>> by something else, resulting in a conflict.
>
> Yes, there is a tiny race window.

Applied.

Thanks,
Rusty.
