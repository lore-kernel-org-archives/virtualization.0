From: "Glauber Costa" <glommer@gmail.com>
Subject: Re: [PATCH 0/2] Paravirt loops per jiffy calculation
Date: Wed, 23 Jul 2008 10:35:22 -0300
Message-ID: <5d6222a80807230635w72cb745bka25af8ded0abec0d__48677.479758817$1216820361$gmane$org@mail.gmail.com>
References: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
	<488702EF.7060305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <488702EF.7060305@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: aliguori@codemonkey.ws, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Glauber Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 23, 2008 at 7:07 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>  Hi,
>
>> Turns out that only implementing a pv get_tsc_khz is not enough, since
>> it will only do the right thing for cpu0, which is not what we desire.
>>
>> So we set preset_lpj. Recall this code is run before arch parameter setup,
>> so if we pass lpj=xx in the command line, it'll still work.
>
> Hmm, why kvm needs the preset_lpj thing and xen doesn't?

I asked myself the same question. But from the snippet in calibrate.c:

        if (preset_lpj) {
                loops_per_jiffy = preset_lpj;
                printk(KERN_INFO
                        "Calibrating delay loop (skipped) preset value.. ");
        } else if ((smp_processor_id() == 0) && lpj_fine) {
                loops_per_jiffy = lpj_fine;
                printk(KERN_INFO
                        "Calibrating delay loop (skipped), "
                        "value calculated using timer frequency.. ");
        } else if ((loops_per_jiffy = calibrate_delay_direct()) != 0) {
                printk(KERN_INFO
                        "Calibrating delay using timer specific routine.. ");


The third one is the one we want to skip. The second one, runs only for CPU0.
calibrate_delay_loop() itself, is called very early from smp_callin,
and tsc calibration only sets lpj_fine. So I don't see too much of an
option here.


> cheers,
>  Gerd
>
> --
> http://kraxel.fedorapeople.org/xenner/
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Glauber Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
