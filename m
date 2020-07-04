From: Colm =?utf-8?q?MacC=C3=A1rthaigh?= <colmmacc-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Fri, 3 Jul 2020 18:33:05 -0700
Message-ID: <5E780027-A6A7-4ED3-AA76-16C2036FF8D4@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org, wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bonzini-mXXj517/zsQ@public.gmane.org, "Graf (AWS), Alexander" <graf-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, "Singh, Balbir" <sblbir-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Sandu, Andrei" <sandreim-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Brooker, Marc" <mbrooker-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Weiss, Radu" <raduweis-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "Manwaring, Derek" <derekmn-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org



On 3 Jul 2020, at 4:04, Jann Horn wrote:

>>  - Provides a simple mechanism to avoid RAM exfiltration during
>>    traditional sleep/hibernate on a laptop or desktop when memory,
>>    and thus secrets, are vulnerable to offline tampering or 
>> inspection.
>
> For the first usecase, I wonder which way around this would work
> better - do the wiping when a VM is saved, or do it when the VM is
> restored? I guess that at least in some scenarios, doing it on restore
> would be nicer because that way the hypervisor can always instantly
> save a VM without having to wait for the guest to say "alright, I'm
> ready" - especially if someone e.g. wants to take a snapshot of a
> running VM while keeping it running? Or do hypervisors inject such
> ACPI transitions every time they snapshot/save/restore a VM anyway?


Just to answer this - I’d expect wipe-after-save rather than 
wipe-on-restore to be common for some. That provides the most defense 
against secrets ending up on disk or some other durable medium when the 
VM images are being saved.

-
Colm
