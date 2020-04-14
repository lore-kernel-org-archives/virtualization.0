From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] mm, treewide: Rename kzfree() to kfree_sensitive()
Date: Tue, 14 Apr 2020 14:26:48 -0400
Message-ID: <3d8c80cb-68e5-9211-9eda-bc343ed7d894@redhat.com>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com>
 <20200414124854.GQ5920@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <wireguard-bounces@lists.zx2c4.com>
In-Reply-To: <20200414124854.GQ5920@twin.jikos.cz>
Content-Language: en-US
List-Unsubscribe: <https://lists.zx2c4.com/mailman/options/wireguard>,
 <mailto:wireguard-request@lists.zx2c4.com?subject=unsubscribe>
List-Archive: <http://lists.zx2c4.com/pipermail/wireguard/>
List-Post: <mailto:wireguard@lists.zx2c4.com>
List-Help: <mailto:wireguard-request@lists.zx2c4.com?subject=help>
List-Subscribe: <https://lists.zx2c4.com/mailman/listinfo/wireguard>,
 <mailto:wireguard-request@lists.zx2c4.com?subject=subscribe>
Errors-To: wireguard-bounces@lists.zx2c4.com
Sender: "WireGuard" <wireguard-bounces@lists.zx2c4.com>
To: dsterba@suse.cz, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4
List-Id: virtualization@lists.linuxfoundation.org

On 4/14/20 8:48 AM, David Sterba wrote:
> On Mon, Apr 13, 2020 at 05:15:49PM -0400, Waiman Long wrote:
>>  fs/btrfs/ioctl.c                              |  2 +-
>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 40b729dce91c..eab3f8510426 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -2691,7 +2691,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>>  	btrfs_put_root(root);
>>  out_free:
>>  	btrfs_free_path(path);
>> -	kzfree(subvol_info);
>> +	kfree_sensitive(subvol_info);
> This is not in a sensitive context so please switch it to plain kfree.
> With that you have my acked-by. Thanks.
>
Thanks for letting me know about. I think I will send it out as a
separate patch.

Cheers,
Longman
