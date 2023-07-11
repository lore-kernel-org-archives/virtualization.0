Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE91CEB64DD
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 17:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 399B660FAB;
	Tue, 11 Jul 2023 17:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 399B660FAB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=i/6zzX3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7liOXZy5UzBT; Tue, 11 Jul 2023 17:41:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EA486110A;
	Tue, 11 Jul 2023 17:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EA486110A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D5F2C0072;
	Tue, 11 Jul 2023 17:41:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA5D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 17:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0A66408FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 17:41:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0A66408FB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=i/6zzX3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mo7UuVEw1N64
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 17:41:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11E8A408C1
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11E8A408C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 17:41:44 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5636ab8240cso3213184eaf.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689097304; x=1691689304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XqwavEubtW11DfezKBW1NY+jd+4AjXNT0PZqqB15Nt8=;
 b=i/6zzX3Bg2TMosmLksrm/UxDzKbRAodFwSPXaH/Vytf0QgUb+80Wu1V8JmVGImV5LN
 UqW3cS/HPgGTnSqq+5ESnms5mlWlOrpNMQBOjQecBdmdh1Qxovd20JgRqOKawY3t9zmR
 8z2rYMuYUOntge5lNy8IseBJ2ChSCyLgER3ClHPXPDG0oOE6oa4GK4VnHU7S42X1Hi4B
 TMzz+5oUZozjyXwv07IZJK2jOZ/I/uSgxO4tTLFJt7TyseewviL/zKqve2XtMJA9ws0o
 ujgREJqUFkaajB6bpb2hMmTVenIDlizLkqJ24PmCXPlK8wxGJF3cqEpoPXWpSksjt4A0
 IReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689097304; x=1691689304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqwavEubtW11DfezKBW1NY+jd+4AjXNT0PZqqB15Nt8=;
 b=YG4tk8o1PI1e1OfFJnfr7VoDwu27MTqd9IlGlljaJHcAoMbhwohnR9kD1GFXN+E9s7
 +SQ9QodekLh1AYwOHrsPZoLLhkzm9TurNFX3W0qX6Ui9xiBNyD+0nUY2d7GkEHiSu1SR
 Id5mxaz9oUPNVyQ/rq852EJU+M5BOzfoWyJVbX8kAPVR/FqKrpge0bPiZi0CY/M2Wx8K
 rlL16tDnsKrM+w1eT9IY0I4pAupD9MqIH34Q3z4yEJu40LvAWNmEsH/Zk78mI7+mOkvD
 pK0QEsRdk8A1aL3YvLb/pRt6/Y5iFUyik4uhqPki28TaR9aXN0x3vilKqxQ4oxcMb172
 LWbg==
X-Gm-Message-State: ABy/qLYcXq4Ct6CK9P7W/uQ1ilDwJMrwY5hCAgl3wpmQTCBSeWVMKUsh
 oT+33FbJHVEo6KgmF5UQXJdOms4IQihiQbRFvz8=
X-Google-Smtp-Source: APBJJlGe64gVAtS1acHTyQl/DOyhaAkZ2zneyvrZc9Qw2Ny+KlNytYjI1BYI0HN9iOBHx77y7dEUQCWTmZDVTl7/DpU=
X-Received: by 2002:a4a:3744:0:b0:563:516e:ae3d with SMTP id
 r65-20020a4a3744000000b00563516eae3dmr9781979oor.6.1689097303762; Tue, 11 Jul
 2023 10:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
In-Reply-To: <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Jul 2023 13:41:31 -0400
Message-ID: <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 11 Jul 2023 at 13:06, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
> since I found a few things in the virtio-scsi driver...
>
> FYI we have seen that Linux has problems with a QEMU patch for the
> virtio-scsi device (details at the bottom of this email in the revert
> commit message and BZ).
>
>
> This is what I found when I looked at the Linux code:
>
> In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
> scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
> 1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
> (sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
>
> When `sdev_target->expecting_lun_change = 1` is set and we call
> scsi_check_sense(), for example to check the next UNIT ATTENTION, it
> will return NEEDS_RETRY, that I think will cause the issues we are
> seeing.
>
> `sdev_target->expecting_lun_change` is reset only in
> scsi_decide_disposition() when `REPORT_LUNS` command returns with
> SAM_STAT_GOOD.
> That command is issued in scsi_report_lun_scan() called by
> __scsi_scan_target(), called for example by scsi_scan_target(),
> scsi_scan_host(), etc.
>
> So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
> and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
> send also the UNIT ATTENTION.
>
> In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
> (hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
> will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
> command to the device. This does not happen for
> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
> UNIT ATTENTION from the hotunplug in QEMU, everything works well.
>
> So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:
>
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bd5633667d01..c57658a63097 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -291,6 +291,7 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>                  }
>                  break;
>          case VIRTIO_SCSI_EVT_RESET_REMOVED:
> +               scsi_scan_host(shost);
>                  sdev = scsi_device_lookup(shost, 0, target, lun);
>                  if (sdev) {
>                          scsi_remove_device(sdev);
>
> This somehow helps, now linux only breaks if the plug/unplug frequency
> is really high. If I put a 5 second sleep between plug/unplug events, it
> doesn't break (at least for the duration of my test which has been
> running for about 30 minutes, before it used to break after about a
> minute).
>
> Another thing I noticed is that in QEMU maybe we should set the UNIT
> ATTENTION first and then send the event on the virtqueue, because the
> scan should happen after the unit attention, but I don't know if in any
> case the unit attention is processed before the virtqueue.
>
> I mean something like this:
>
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 45b95ea070..13db40f4f3 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1079,8 +1079,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           };
>
>           virtio_scsi_acquire(s);
> -        virtio_scsi_push_event(s, &info);
>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> +        virtio_scsi_push_event(s, &info);
>           virtio_scsi_release(s);
>       }
>   }
> @@ -1111,8 +1111,8 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>
>       if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>           virtio_scsi_acquire(s);
> -        virtio_scsi_push_event(s, &info);
>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> +        virtio_scsi_push_event(s, &info);
>           virtio_scsi_release(s);
>       }
>   }

That is racy. It's up to the guest whether the event virtqueue or the
UNIT ATTENTION will be processed first.

If the device wants to ensure ordering then it must withhold the event
until the driver has responded to the UNIT ATTENTION. That may not be
a good idea though.

I'd like to understand the root cause before choosing a solution.

> At this point I think the problem is on the handling of the
> VIRTIO_SCSI_EVT_RESET_REMOVED event in the virtio-scsi driver, where
> somehow we have to redo the bus scan, but scsi_scan_host() doesn't seem
> to be enough when the event rate is very high.

Why is it necessary to rescan the whole bus instead of removing just
the device that has been unplugged?

> I don't know if along with this fix, we also need to limit the rate in
> QEMU somehow.

Why is a high rate problematic?

> Sorry for the length of this email, but I'm not familiar with SCSI and
> wanted some suggestions on how to proceed.
>
> Paolo, Stefan, Linux SCSI maintainers, any suggestion?

I don't know the Linux SCSI code well enough to say, sorry. I think we
need input from someone familiar with the code.

However, QEMU is not at liberty to make changes that break existing
guests. So even if it turns out the specs allow something or there is
an existing bug in virtio_scsi.ko, we still can't break existing
guests.

Stefan

>
>
> Thanks,
> Stefano
>
> On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
> >This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> >
> >That commit causes several problems in Linux as described in the BZ.
> >In particular, after a while, other devices on the bus are no longer
> >usable even if those devices are not affected by the hotunplug.
> >This may be a problem in Linux, but we have not been able to identify
> >it so far. So better to revert this patch until we find a solution.
> >
> >Also, Oracle, which initially proposed this patch for a problem with
> >Solaris, seems to have already reversed it downstream:
> >    https://linux.oracle.com/errata/ELSA-2023-12065.html
> >
> >Suggested-by: Thomas Huth <thuth@redhat.com>
> >Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> >Cc: qemu-stable@nongnu.org
> >Cc: Mark Kanda <mark.kanda@oracle.com>
> >Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >---
> > include/hw/scsi/scsi.h |  1 -
> > hw/scsi/scsi-bus.c     | 18 ------------------
> > hw/scsi/virtio-scsi.c  |  2 --
> > 3 files changed, 21 deletions(-)
> >
> >diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> >index e2bb1a2fbf..7c8adf10b1 100644
> >--- a/include/hw/scsi/scsi.h
> >+++ b/include/hw/scsi/scsi.h
> >@@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
> >                                       BlockdevOnError rerror,
> >                                       BlockdevOnError werror,
> >                                       const char *serial, Error **errp);
> >-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
> > void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
> >
> > SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
> >diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> >index f80f4cb4fc..42a915f8b7 100644
> >--- a/hw/scsi/scsi-bus.c
> >+++ b/hw/scsi/scsi-bus.c
> >@@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
> >     return (sense.asc << 8) | sense.ascq;
> > }
> >
> >-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
> >-{
> >-    int prec1, prec2;
> >-    if (sense.key != UNIT_ATTENTION) {
> >-        return;
> >-    }
> >-
> >-    /*
> >-     * Override a pre-existing unit attention condition, except for a more
> >-     * important reset condition.
> >-     */
> >-    prec1 = scsi_ua_precedence(bus->unit_attention);
> >-    prec2 = scsi_ua_precedence(sense);
> >-    if (prec2 < prec1) {
> >-        bus->unit_attention = sense;
> >-    }
> >-}
> >-
> > void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
> > {
> >     int prec1, prec2;
> >diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> >index 45b95ea070..1f56607100 100644
> >--- a/hw/scsi/virtio-scsi.c
> >+++ b/hw/scsi/virtio-scsi.c
> >@@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >
> >         virtio_scsi_acquire(s);
> >         virtio_scsi_push_event(s, &info);
> >-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> >         virtio_scsi_release(s);
> >     }
> > }
> >@@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> >         virtio_scsi_acquire(s);
> >         virtio_scsi_push_event(s, &info);
> >-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> >         virtio_scsi_release(s);
> >     }
> > }
> >--
> >2.41.0
> >
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
