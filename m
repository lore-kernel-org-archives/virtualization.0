From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: IO controller Mini-Summit 2009
Date: Wed, 14 Oct 2009 13:55:21 -0400
Message-ID: <20091014175521.GG3528__6786.04692589051$1255543369$gmane$org@redhat.com>
References: <20091014.212444.179938286.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091014.212444.179938286.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, Gui Jianfeng <guijianfeng@cn.fujitsu.com>, containers@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Isaku Yamahata <yamahata@valinux.co.jp>, dm-devel@redhat.com, Dong-Jae Kang <baramsori72@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Nauman Rafique <nauman@google.com>, Munehiro Ikeda <m-ikeda@ds.jp.nec.com>, Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 14, 2009 at 09:24:44PM +0900, Ryo Tsuruta wrote:
> Hello,
> 

Hi Ryo,

CCing people who are planning to attend the mini summit either in person
or phone. (As per your list on io mini summit wiki page). Not sure if
everybody is scanning mailing list for update on mini summit.

I am checking out wiki page for more information like Venue. It says the
venue is linux foundation office Japan. Hopefully there is no change in
that information.

What are the conference call details for the people who might want to join
in over phone? Could not find those. Are you yet to post these?

Thanks
Vivek

> I have summarized the topics for the IO controller mini-summit and
> written the ideas seen in the mailing list.
> 
> - The place where IO controller should be implemented
>   - Block layer in conjunction with the IO scheduler
>   - Common layer right above the IO scheduler
>   - CFQ enhancement.
>   - Both block and common layer, users can select whichever controller
>     they want.
>   - VFS layer
> 
> - What kind of bandwidth control policies are needed?
>   - Proportional weight
>   - Enforcing upper limit
>   - Minimum bandwidth guarantee
> 
> - How to handle buffered writes?
>   - Add dirt-ratio in the memory controller
>   - Add bufferred-write-cgroup to track buffered writebacks
>   - A per group per bdi pdflush threads
> 
> - Who should be charged for swap activity?
>   - who requests a page.
>   - who has a page.
>   - All swap activities are charged to the root group.
> 
> And I would also like to discuss about the followings.
> 
> - Extensions of struct bio
>   - Make a bio point to the io_context of a process which creates the
>     I/O request. This allows to pass the IO scheduling class and
>     priority information to IO controller even if the IO is submitted
>     by another process which does not create the request, such as a
>     worker thread.
>   - Add a new flag to struct bio to identify the bio as urgent. This
>     gives IO controller a chance to handle the bio as high
>     priority. This flag should be set if the bio is created for the
>     page-out operation. 
> 
> - Common test methods to verify the functionality of IO controller.
> 
> Please give me comments and suggestions. I may be missing or
> misunderstanding something.
> 
> Thanks,
> Ryo Tsuruta
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
