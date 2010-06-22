From: john cooper <john.cooper@redhat.com>
Subject: Re: [PATCH 1/2] Add 'serial' attribute to virtio-blk devices
Date: Mon, 21 Jun 2010 23:40:50 -0400
Message-ID: <4C2030C2.1060904@redhat.com>
References: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
	<4C1EFDFD.5050907@redhat.com> <20100621164321.GF1647@us.ibm.com>
	<201006220855.21925.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201006220855.21925.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: john.cooper@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tue, 22 Jun 2010 02:13:21 am Ryan Harper wrote:
>> * john cooper <john.cooper@redhat.com> [2010-06-21 01:11]:
>>> Rusty Russell wrote:
>>>> 	/* id_str is not necessarily nul-terminated! */
>>>> 	buf[VIRTIO_BLK_ID_BYTES] = '\0';
>>>> 	return virtblk_get_id(disk, buf);
>>> The /sys file is rendered according to the length
>>> returned from this function and the trailing nul
>>> is not interpreted in this context.  In fact if a
>>> nul is added and included in the byte count of the
>>> string it will appear in the /sys file.
>> Yeah; I like the simplicity; but we do need to know how long the string
>> is so we can return that value. 
> 
> So we're looking at something like:
> 
> 	/* id_str is not necessarily nul-terminated! */
> 	buf[VIRTIO_BLK_ID_BYTES] = '\0';
> 	err = virtblk_get_id(disk, buf);
> 	if (!err)
> 		return strlen(buf);
> 	if (err == -EIO) /* Unsupported?  Make it empty. */	
> 		return 0;
> 	return err;

In my haste reading your prior mail, I'd glossed over
the fact you were copying direct to the sysfs buf.  So
in retrospect that (and the above) do make sense.

Thanks,

-john

-- 
john.cooper@redhat.com
