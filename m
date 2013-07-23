From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V3 0/2] [BUGFIX] virtio/console: Fix two bugs of
	splice_write
Date: Tue, 23 Jul 2013 11:21:09 +0930
Message-ID: <87txjm9h82.fsf__25272.3146150403$1374553554$gmane$org@rustcorp.com.au>
References: <20130722040043.7531.78801.stgit@yunodevel>
	<20130722063341.GA1806@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130722063341.GA1806@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, yrl.pp-manager.tt@hitachi.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Mon) 22 Jul 2013 [13:00:43], Yoshihiro YUNOMAE wrote:
>> Hi,
>> 
>> This patch set fixes two bugs of splice_write in the virtio-console driver.
>> 
>> [BUG1] Although pipe->nrbufs is empty, the driver tries to do splice_write.
>>        => This induces oops in sg_init_table().
>> 
>> [BUG2] No lock for competition of splice_write.
>>        => This induces oops in splice_from_pipe_feed() by bug of any user
>>           application.
>> 
>> These reports are written in each patch.
>> 
>> Changes in V2:
>> - Fix a locking problem for error
>> 
>> Changes in V3:
>> - Add Reviewed-by lines and stable@ line in sign-off area
>
> Thank you!
>
> Rusty, please pick this up.

Both applied, thankyou.

Cheers,
Rusty.
