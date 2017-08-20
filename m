From: Stephen Hemminger via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 4/4] mlx4: sizeof style usage
Date: Sun, 20 Aug 2017 18:00:27 +0000
Message-ID: <DM2PR21MB0074E2B2C697B1300B77EFEACC860__2987.59811926193$1503252041$gmane$org@DM2PR21MB0074.namprd21.prod.outlook.com>
References: <20170815172919.26153-1-sthemmin@microsoft.com>
	<20170815172919.26153-5-sthemmin@microsoft.com>
	<d38cac6d-77a7-e411-73b0-78adad9cbd5f@mellanox.com>
Reply-To: Stephen Hemminger <sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d38cac6d-77a7-e411-73b0-78adad9cbd5f@mellanox.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tariq Toukan <tariqt@mellanox.com>, Stephen Hemminger <stephen@networkplumber.org>, "mlindner@marvell.com" <mlindner@marvell.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Yes, good catch.

-----Original Message-----
From: Tariq Toukan [mailto:tariqt@mellanox.com] 
Sent: Sunday, August 20, 2017 3:27 AM
To: Stephen Hemminger <stephen@networkplumber.org>; mlindner@marvell.com; mst@redhat.com; jasowang@redhat.com
Cc: netdev@vger.kernel.org; linux-rdma@vger.kernel.org; virtualization@lists.linux-foundation.org; Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH net-next 4/4] mlx4: sizeof style usage

[You don't often get email from TARIQT@MELLANOX.COM. Learn why this is important at http://aka.ms/LearnAboutSenderIdentification.]

Thanks Stephen.
Sorry for the late reply, I was on vacation.
I know this is already accepted, but still I have one comment.

On 15/08/2017 8:29 PM, Stephen Hemminger wrote:
> The kernel coding style is to treat sizeof as a function
> (ie. with parenthesis) not as an operator.
>
> Also use kcalloc and kmalloc_array
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> @@ -726,7 +726,7 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
>                       }
>                       memcpy(&priv->mfunc.master.comm_arm_bit_vector,
>                              eqe->event.comm_channel_arm.bit_vec,
> -                            sizeof eqe->event.comm_channel_arm.bit_vec);
> +                            sizeof(eqe)->event.comm_channel_arm.bit_vec);

I think the brackets here are misplaced.
Shouldn't they be as follows?

sizeof(eqe->event.comm_channel_arm.bit_vec));

>                       queue_work(priv->mfunc.master.comm_wq,
>                                  &priv->mfunc.master.comm_work);
>                       break;

Thanks,
Tariq
