From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Tue, 21 Aug 2012 10:48:17 +0200
Message-ID: <50334B51.6050900@redhat.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cong Meng <mc@linux.vnet.ibm.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 21/08/2012 10:23, Cong Meng ha scritto:
> +static void sg_get_queue_limits(BlockDriverState *bs, const char *filename)
> +{
> +    DIR *ffs;
> +    struct dirent *d;
> +    char path[MAXPATHLEN];
> +
> +    snprintf(path, MAXPATHLEN,
> +             "/sys/class/scsi_generic/sg%s/device/block/",
> +             filename + strlen("/dev/sg"));
> +
> +    ffs = opendir(path);
> +    if (!ffs) {
> +        return;
> +    }
> +
> +    for (;;) {
> +        d = readdir(ffs);
> +        if (!d) {
> +            return;
> +        }
> +
> +        if (strcmp(d->d_name, ".") == 0 || strcmp(d->d_name, "..") == 0) {
> +            continue;
> +        }
> +
> +        break;
> +    }
> +
> +    closedir(ffs);
> +
> +    pstrcat(path, MAXPATHLEN, d->d_name);
> +    pstrcat(path, MAXPATHLEN, "/queue/");
> +
> +    read_queue_limit(path, "max_sectors_kb", &bs->max_sectors);
> +    read_queue_limit(path, "max_segments", &bs->max_segments);
> +    read_queue_limit(path, "max_segment_size", &bs->max_segment_size);
> +}

Using /sys/dev/block or /sys/dev/char seems easier, and lets you
retrieve the parameters for block devices too.

However, I'm worried of the consequences this has for migration.  You
could have the same physical disk accessed with two different HBAs, with
different limits.  So I don't know if this can really be solved at all.

Paolo
