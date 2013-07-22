From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: Re: Re: [PATCH V2 0/2] [BUGFIX] virtio/console: Fix two bugs of
	splice_write
Date: Mon, 22 Jul 2013 10:05:26 +0900
Message-ID: <51EC8556.9040101@hitachi.com>
References: <20130719091951.9698.95194.stgit@yunodevel>
	<20130719100543.GM3087@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130719100543.GM3087@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, yrl.pp-manager.tt@hitachi.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Amit,

Sorry for the late reply.

(2013/07/19 19:05), Amit Shah wrote:
> On (Fri) 19 Jul 2013 [18:19:51], Yoshihiro YUNOMAE wrote:
>> Hi,
>>
>> This patch set fixes two bugs of splice_write in the virtio-console driver.
>>
>> [BUG1] Although pipe->nrbufs is empty, the driver tries to do splice_write.
>>         => This induces oops in sg_init_table().
>>
>> [BUG2] No lock for competition of splice_write.
>>         => This induces oops in splice_from_pipe_feed() by bug of any user
>>            application.
>>
>> These reports are written in each patch.
>>
>> Changes in V2:
>> - Fix a locking problem for error
>>
>> Thanks!
>
> Reviewed-by: Amit Shah <amit.shah@redhat.com>

Thank you for reviewing this patch set.

> For the patches to be picked up in the stable trees, you need to
> include CC: <stable@vger.kernel.org> in the sign-off area of the
> patches, just cc'ing in the patch posting doesn't help.  See
> Documentation/stable_kernel_rules.txt.
>
> Can you submit a v3 with that change, and also add my reviewed-by
> line?

Sure. I'll add stable@ line, your reviewed-by line, and Masami's
reviewed-by line in sign-off area for each patch.

Thanks,
Yoshihiro YUNOMAE

-- 
Yoshihiro YUNOMAE
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: yoshihiro.yunomae.ez@hitachi.com
